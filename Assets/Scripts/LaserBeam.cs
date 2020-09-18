using UnityEngine;
using static WeaponManager;

public class LaserBeam : MonoBehaviour, IWeapon {
    public float laserDamage = 0.5f;
    private readonly float _laserLengthOff = 0f;
    private readonly float _laserLengthOn = 30f;
    private GameObject _laserBeam;
    private Collider _laserCollider;
    private bool _laserIsOn;
    private Vector3 _laserScale;
    private float laserTimer;

    private void Awake(){
        _laserScale.z = _laserLengthOff;
        _laserBeam.transform.localScale = _laserScale;
        _laserIsOn = false;
        laserTimer = 2f;
    }

    private void Update(){
        if (_laserIsOn) laserTimer -= Time.unscaledDeltaTime;
        if (laserTimer <= 0f) {
            _laserIsOn = false;
            _laserScale.z = _laserLengthOff;
            _laserBeam.transform.localScale = _laserScale;
            _laserCollider.enabled = false;
            _laserIsOn = false;
            if (_laserBeam != null) WeaponPool.Instance.ReturnToPool(_laserBeam);
        }
    }


    private void OnTriggerEnter(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(laserDamage);
    }


    private void OnTriggerExit(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(laserDamage);
    }

    private void OnTriggerStay(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(laserDamage);
    }

    public void Shoot(){
        if (_laserIsOn) return;
        if (_laserBeam != null) return;
        _laserBeam = WeaponPool.Instance.Get(WeaponType.Laser);
        _laserBeam.SetActive(true);
        _laserIsOn = true;
        _laserScale.z = _laserLengthOn;
        _laserBeam.transform.localScale = _laserScale;
        _laserCollider = _laserBeam.GetComponent<Collider>();
        _laserCollider.enabled = true;
    }
}